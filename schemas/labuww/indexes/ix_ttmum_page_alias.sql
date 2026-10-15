-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labuww.labuww_page USING btree (alias);


--
