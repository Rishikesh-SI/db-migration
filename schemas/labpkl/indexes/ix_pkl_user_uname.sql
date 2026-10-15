-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_user_uname
-- Type: INDEX

-- Name: ix_pkl_user_uname; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE UNIQUE INDEX ix_pkl_user_uname ON labpkl.labpkl_user USING btree (user_name);


--
