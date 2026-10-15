-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labets; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labets.labets_page USING btree (alias);


--
