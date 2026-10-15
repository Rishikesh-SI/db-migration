-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: ix_ttmum_page_alias
-- Type: INDEX

-- Name: ix_ttmum_page_alias; Type: INDEX; Schema: labpc; Owner: -
--

CREATE INDEX ix_ttmum_page_alias ON labpc.labpc_page USING btree (alias);


--
