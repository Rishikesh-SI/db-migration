-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labwf; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labwf.labwf_page USING btree (alias);


--
