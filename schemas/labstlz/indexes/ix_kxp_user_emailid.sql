-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_user_emailid
-- Type: INDEX

-- Name: ix_kxp_user_emailid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_user_emailid ON labstlz.labstlz_user USING btree (email_id);


--
