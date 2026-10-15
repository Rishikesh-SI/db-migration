-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_page_alias
-- Type: INDEX

-- Name: ix_khi_page_alias; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_page_alias ON khi.khi_page USING btree (alias);


--
