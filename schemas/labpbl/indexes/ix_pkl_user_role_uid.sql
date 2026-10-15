-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: ix_pkl_user_role_uid
-- Type: INDEX

-- Name: ix_pkl_user_role_uid; Type: INDEX; Schema: labpbl; Owner: -
--

CREATE INDEX ix_pkl_user_role_uid ON labpbl.labpbl_user_role USING btree (user_id);


--
