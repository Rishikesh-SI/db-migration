-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_page_alias
-- Type: INDEX

-- Name: ix_abp_page_alias; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_page_alias ON abpp.abp_page USING btree (alias);


--
