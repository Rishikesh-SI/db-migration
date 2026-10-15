-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labupw; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labupw.labupw_page USING btree (alias);


--
