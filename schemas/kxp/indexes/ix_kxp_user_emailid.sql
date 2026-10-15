-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_user_emailid
-- Type: INDEX

-- Name: ix_kxp_user_emailid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_user_emailid ON kxp.kxp_user USING btree (email_id);


--
