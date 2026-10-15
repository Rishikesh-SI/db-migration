-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: ix_pkl_page_alias
-- Type: INDEX

-- Name: ix_pkl_page_alias; Type: INDEX; Schema: labpbl; Owner: -
--

CREATE INDEX ix_pkl_page_alias ON labpbl.labpbl_page USING btree (alias);


--
