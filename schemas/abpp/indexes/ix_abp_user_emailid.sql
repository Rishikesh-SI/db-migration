-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_user_emailid
-- Type: INDEX

-- Name: ix_abp_user_emailid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_user_emailid ON abpp.abp_user USING btree (email_id);


--
