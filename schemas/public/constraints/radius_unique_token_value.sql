-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: radius unique_token_value
-- Type: CONSTRAINT

-- Name: radius unique_token_value; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.radius
    ADD CONSTRAINT unique_token_value UNIQUE (token, value);


--
