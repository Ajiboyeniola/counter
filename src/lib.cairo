#[starknet::interface]
trait ICounterContract<TContractState> {
    fn increment_count(ref self: TContractState);
    fn decrement_count(ref self: TContractState);
    fn get_current_count(self: @TContractState) -> u256;
}

#[starknet::contract]
mod Counter {
    use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    #[storage]
    struct Storage {
        counter: u256, 
    }

    #[abi(embed_v0)]
    impl CounterImpl of super::ICounterContract<ContractState> {
        fn increment_count(ref self: ContractState) {
            let mut counter: u256 = self.counter.read() + 1;
            self.counter.write(counter);
        }

        fn decrement_count(ref self: ContractState) {
            let mut counter: u256 = self.counter.read() - 1;
            self.counter.write(counter);
        }

        fn get_current_count(self: @ContractState) -> u256 {
            return self.counter.read();
        }
    }
}
