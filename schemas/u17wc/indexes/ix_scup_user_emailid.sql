-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_user_emailid
-- Type: INDEX

-- Name: ix_scup_user_emailid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_user_emailid ON u17wc.u17wc_user USING btree (email_id);


--
