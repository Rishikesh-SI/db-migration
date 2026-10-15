-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_user_role_rid
-- Type: INDEX

-- Name: ix_pkl_user_role_rid; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_user_role_rid ON labpkl.labpkl_user_role USING btree (role_id);


--
