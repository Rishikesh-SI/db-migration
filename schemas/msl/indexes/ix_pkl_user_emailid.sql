-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_user_emailid
-- Type: INDEX

-- Name: ix_pkl_user_emailid; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_user_emailid ON msl.msl_user USING btree (email_id);


--
