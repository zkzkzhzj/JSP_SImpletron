package simpletron;

import java.util.Scanner;

public class Simpletron {

	public static void main(String[] args) {
		final int READ = 10;
		final int WRITE = 11;

		final int LOAD = 20;
		final int STORE = 21;

		final int ADD = 30;
		final int SUBSTRACT = 31;
		final int DIVIDE = 32;
		final int MULTIPLY = 33;

		final int BRANCH = 40;
		final int BRANCHNEG = 41;
		final int BRANCHZERO = 42;
		final int HALT = 43;

		int accumulator = 0;
		int instructionCounter = 0;
		int instructionRegister = 0;
		int operationCode = 0;
		int operand = 0;

		int num = 0;

		int memory[] = new int[100];

		Scanner sc = new Scanner(System.in);

		System.out.println("*** Welcome to Simpletron! ***");
		System.out.println("*** Please enter your program one istruction ***");
		System.out.println("*** (or data word) at a time. I will type the ***");
		System.out.println("*** location num and a question mark (?) ***");
		System.out.println("*** You then type the word for that location. ***");
		System.out.println("*** Type the sectinel -99999 to stop entering ***");
		System.out.println("*** your program ****");
		System.out.println();

		for (int i = 0; i < 100; i++) {
			System.out.printf("%02d  ?  ", i);
			num = sc.nextInt();

			if (num == -99999) {
				break;
			}

			if (num > 9999 || num < -9999) {
				System.out.println("9999 ~ -9999 ���̷� �Է����ּ���.");
				i--;
			} else {
				memory[i] = num;
			}
		}

		for (instructionCounter = 0; instructionCounter < memory.length; instructionCounter++) {
			instructionRegister = memory[instructionCounter];

			operationCode = instructionRegister / 100;
			operand = instructionRegister % 100;

			switch (operationCode) {

			case READ:
				System.out.printf(" ���ڸ� �Է����ּ��� : ");
				memory[operand] = sc.nextInt();
				break;

			case WRITE:
				System.out.printf("��� �� : %04d\n\n", memory[operand]);
				break;

			case LOAD:
				accumulator = memory[operand];
				break;

			case STORE:
				memory[operand] = accumulator;
				break;

			case ADD:
				accumulator += memory[operand];
				break;

			case SUBSTRACT:
				accumulator -= memory[operand];
				break;

			case DIVIDE:
				accumulator /= memory[operand];
				break;

			case MULTIPLY:
				accumulator *= memory[operand];
				break;

			case BRANCH:
				instructionCounter = operand - 1;
				break;

			case BRANCHNEG:
				if (accumulator < 0)
					instructionCounter = operand - 1;
				break;

			case BRANCHZERO:
				if (accumulator == 0)
					instructionCounter = operand - 1;
				break;

			case HALT:
				break;

			}

			if (operationCode == HALT) {
				break;
			}
		}

		System.out.println("REGISTERS : ");
		System.out.println("accumulator\t\t\t" + accumulator);
		System.out.println("instructionCounter\t\t" + instructionCounter);
		System.out.println("instructionRegister\t\t" + instructionRegister);
		System.out.println("operationCode\t\t\t" + operationCode);
		System.out.println("operand\t\t\t\t" + operand);
		System.out.println("\nMEMORY : ");

		for (int i = 0; i < 10; i++) {
			System.out.printf("\t%5d", i); // 0~9
		}
		System.out.println();

		for (int i = 0; i < memory.length; i++) {
			if (i % 10 == 0 && i != 0) {
				System.out.println();
			}
			if (i % 10 == 0) {
				System.out.printf(" %2d", i);
			}
			if (memory[i] >= 0) {
				System.out.printf("\t+%04d", memory[i]);
			} else {
				System.out.printf("\t-%04d", -memory[i]);
			}
		}
	}
}