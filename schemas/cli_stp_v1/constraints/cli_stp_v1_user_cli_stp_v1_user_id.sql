-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_user cli_stp_v1_user_id
-- Type: CONSTRAINT

-- Name: cli_stp_v1_user cli_stp_v1_user_id; Type: CONSTRAINT; Schema: cli_stp_v1; Owner: -
--

ALTER TABLE ONLY cli_stp_v1.cli_stp_v1_user
    ADD CONSTRAINT cli_stp_v1_user_id PRIMARY KEY (user_id);


--
