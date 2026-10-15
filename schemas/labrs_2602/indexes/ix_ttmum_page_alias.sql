-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labrs_2602; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labrs_2602.labrs_page USING btree (alias);


--
