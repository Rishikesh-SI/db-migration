-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labpvl.labpvl_page USING btree (alias);


--
