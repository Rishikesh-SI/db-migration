-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_page_alias
-- Type: INDEX

-- Name: ix_pkl_page_alias; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_page_alias ON labpkl_v1.labpkl_v1_page USING btree (alias);


--
