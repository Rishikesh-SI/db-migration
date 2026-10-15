-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_redirect_old_alias
-- Type: INDEX

-- Name: ix_abp_redirect_old_alias; Type: INDEX; Schema: abpp; Owner: -
--

CREATE UNIQUE INDEX ix_abp_redirect_old_alias ON abpp.abp_redirect USING btree (old_alias);


--
