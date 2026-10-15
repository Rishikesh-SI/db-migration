-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_user_role_uid
-- Type: INDEX

-- Name: ix_pkl_user_role_uid; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_user_role_uid ON labpkl.labpkl_user_role USING btree (user_id);


--
