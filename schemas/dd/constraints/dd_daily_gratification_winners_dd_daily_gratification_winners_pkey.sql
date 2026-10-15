-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_daily_gratification_winners dd_daily_gratification_winners_pkey
-- Type: CONSTRAINT

-- Name: dd_daily_gratification_winners dd_daily_gratification_winners_pkey; Type: CONSTRAINT; Schema: dd; Owner: -
--

ALTER TABLE ONLY dd.dd_daily_gratification_winners
    ADD CONSTRAINT dd_daily_gratification_winners_pkey PRIMARY KEY (gratification_detail_id);


--
