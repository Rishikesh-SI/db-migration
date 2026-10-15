-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: ix_kxp_user_emailid
-- Type: INDEX

-- Name: ix_kxp_user_emailid; Type: INDEX; Schema: labkxp; Owner: -
--

CREATE INDEX ix_kxp_user_emailid ON labkxp.labkxp_user USING btree (email_id);


--
