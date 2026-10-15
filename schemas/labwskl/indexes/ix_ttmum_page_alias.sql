-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labwskl; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labwskl.labwskl_page USING btree (alias);


--
