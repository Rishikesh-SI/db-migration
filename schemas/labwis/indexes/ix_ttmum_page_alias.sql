-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labwis; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labwis.labwis_page USING btree (alias);


--
