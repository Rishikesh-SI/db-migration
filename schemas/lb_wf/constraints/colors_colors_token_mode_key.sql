-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: colors colors_token_mode_key
-- Type: CONSTRAINT

-- Name: colors colors_token_mode_key; Type: CONSTRAINT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.colors
    ADD CONSTRAINT colors_token_mode_key UNIQUE (token, mode);


--
