﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Phantom_of_the_West.Visual_Novel
{
	public class BlankStoryChoice : IStoryChoice
	{
		public string Text
		{
			get
			{
				return "";
			}
		}

		public void Select()
		{
		}
	}
}