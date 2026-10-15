-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_user_emailid
-- Type: INDEX

-- Name: ix_pkl_user_emailid; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_user_emailid ON labpkl_v1.labpkl_v1_user USING btree (email_id);


--
