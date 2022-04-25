'''
Solidity function from Scaffold-eth
https://medium.com/@austin_48503/decentralized-deployment-7d975c9d5016

function price(uint256 input_amount, uint256 input_reserve, uint256 output_reserve) public view returns (uint256) {
  uint256 input_amount_with_fee = input_amount.mul(997);
  uint256 numerator = input_amount_with_fee.mul(output_reserve);
  uint256 denominator = input_reserve.mul(1000).add(input_amount_with_fee);
  return numerator / denominator;
}
'''

'''
Calculate the number of B tokens that will be returned for a given
number of A tokens. Uses a transaction fee of .3% and constant mean product.

Args:
  input_amount: the number of A tokens
  input_reserve: the current number of A tokens that the DEX currently has
  output_reserve: the current number of B tokens that the DEX currently has
Returns:
  The number of B tokens that will be given in exchange for
    input_amount number of A tokens
'''
def swap_with_tx_fee(input_amount, input_reserve, output_reserve):
  input_amount_fee = input_amount * 997
  numerator = input_amount_fee * output_reserve
  denominator = (input_reserve * 1000) + input_amount_fee
  result =  round(numerator / denominator, 4)
  print(f"WITH .3% tx fee.")
  print(f"Input reserve: {input_reserve}. Output reserve: {output_reserve}.")
  print(f"Trading {input_amount} 'A' tokens for {result} 'B' tokens.\n")
  return result

def swap_with_no_tx_fee(input_amount, input_reserve, output_reserve):
  numerator = input_amount * output_reserve
  denominator = input_reserve + input_amount
  result =  round(numerator / denominator, 4)
  print(f"WITHOUT tx fee.")
  print(f"Input reserve: {input_reserve}. Output reserve: {output_reserve}.")
  print(f"Trading {input_amount} 'A' tokens for {result} 'B' tokens.\n")
  print(f"----------------------------------------------------")
  return result

input_amount, input_reserve, output_reserve = 1, 1000, 1000
swap_with_tx_fee(input_amount, input_reserve, output_reserve)
swap_with_no_tx_fee(input_amount, input_reserve, output_reserve)

input_amount, input_reserve, output_reserve = 500, 1000, 1000
swap_with_tx_fee(input_amount, input_reserve, output_reserve)
swap_with_no_tx_fee(input_amount, input_reserve, output_reserve)

input_amount, input_reserve, output_reserve = 995, 1000, 1000
swap_with_tx_fee(input_amount, input_reserve, output_reserve)
swap_with_no_tx_fee(input_amount, input_reserve, output_reserve)