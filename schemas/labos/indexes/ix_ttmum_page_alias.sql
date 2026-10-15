-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labos; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labos.labos_page USING btree (alias);


--
