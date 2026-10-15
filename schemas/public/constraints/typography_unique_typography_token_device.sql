-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: typography unique_typography_token_device
-- Type: CONSTRAINT

-- Name: typography unique_typography_token_device; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typography
    ADD CONSTRAINT unique_typography_token_device UNIQUE (token, device);


--
