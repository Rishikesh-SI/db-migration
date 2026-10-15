-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_page_alias
-- Type: INDEX

-- Name: ix_pkl_page_alias; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_page_alias ON labpkl.labpkl_page USING btree (alias);


--
