-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_user_activity_aid
-- Type: INDEX

-- Name: ix_pkl_user_activity_aid; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_user_activity_aid ON labpkl.labpkl_user_activity USING btree (user_id);


--
