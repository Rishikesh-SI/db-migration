-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_user_role_rid
-- Type: INDEX

-- Name: ix_pkl_user_role_rid; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_user_role_rid ON labjfc.labjfc_user_role USING btree (role_id);


--
