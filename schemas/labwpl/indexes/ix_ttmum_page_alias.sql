-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labwpl; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labwpl.labwpl_page USING btree (alias);


--
