-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_user_emailid
-- Type: INDEX

-- Name: ix_stn_user_emailid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_user_emailid ON stn.stn_user USING btree (email_id);


--
