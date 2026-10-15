-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_user_emailid
-- Type: INDEX

-- Name: ix_isl_user_emailid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_user_emailid ON isl.isl_user USING btree (email_id);


--
