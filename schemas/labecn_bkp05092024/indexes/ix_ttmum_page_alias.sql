-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp05092024
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labecn_bkp05092024; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labecn_bkp05092024.labecn_page USING btree (alias);


--
