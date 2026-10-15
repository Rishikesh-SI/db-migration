-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_user_emailid
-- Type: INDEX

-- Name: ix_kxp_user_emailid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_user_emailid ON labkxp1.labkxp_user USING btree (email_id);


--
