-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labdsp; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labdsp.labdsp_page USING btree (alias);


--
