-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_tmm_og_user_email
-- Type: INDEX

-- Name: ix_tmm_og_user_email; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_tmm_og_user_email ON tmm.tmm_og_user_master USING btree (upper(email_id));


--
