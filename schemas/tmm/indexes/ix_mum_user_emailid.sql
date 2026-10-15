-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_user_emailid
-- Type: INDEX

-- Name: ix_mum_user_emailid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_user_emailid ON tmm.tmm_user USING btree (email_id);


--
