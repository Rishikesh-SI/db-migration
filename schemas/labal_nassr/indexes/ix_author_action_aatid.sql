-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labal_nassr; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labal_nassr.labal_nassr_author_action USING btree (asset_type_id, asset_id);


--
