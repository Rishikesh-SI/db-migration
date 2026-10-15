-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labgsoc; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labgsoc.labgsoc_page USING btree (alias);


--
