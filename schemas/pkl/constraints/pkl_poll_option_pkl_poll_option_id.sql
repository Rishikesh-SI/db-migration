-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_poll_option pkl_poll_option_id
-- Type: CONSTRAINT

-- Name: pkl_poll_option pkl_poll_option_id; Type: CONSTRAINT; Schema: pkl; Owner: -
--

ALTER TABLE ONLY pkl.pkl_poll_option
    ADD CONSTRAINT pkl_poll_option_id PRIMARY KEY (poll_option_id);


--
