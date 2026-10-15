-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_user_emailid
-- Type: INDEX

-- Name: ix_ppb_user_emailid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_user_emailid ON ppb.ppb_user USING btree (email_id);


--
