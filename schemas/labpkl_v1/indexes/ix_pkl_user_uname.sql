-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_user_uname
-- Type: INDEX

-- Name: ix_pkl_user_uname; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE UNIQUE INDEX ix_pkl_user_uname ON labpkl_v1.labpkl_v1_user USING btree (user_name);


--
