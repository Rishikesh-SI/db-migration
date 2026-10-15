-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labirao; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labirao.labirao_page USING btree (alias);


--
