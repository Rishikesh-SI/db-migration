-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labboost; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labboost.labboost_page USING btree (alias);


--
