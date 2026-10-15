-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: spacing unique_spacing_token_value
-- Type: CONSTRAINT

-- Name: spacing unique_spacing_token_value; Type: CONSTRAINT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.spacing
    ADD CONSTRAINT unique_spacing_token_value UNIQUE (token, value);


--
