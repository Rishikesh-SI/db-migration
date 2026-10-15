-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_redirect_old_alias
-- Type: INDEX

-- Name: ix_pkl_redirect_old_alias; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE UNIQUE INDEX ix_pkl_redirect_old_alias ON labpkl.labpkl_redirect USING btree (old_alias);


--
