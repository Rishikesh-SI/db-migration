-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labrlp; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labrlp.labrlp_page USING btree (alias);


--
